// Contexto: practica nueva de MongoDB sobre sample_airbnb.listingsAndReviews.
// Solo lectura (find y aggregate): no modifica los datos de la coleccion.

use('sample_airbnb');

// 1. $or: listings baratos (< 50) o con mas de 30 reseñas
db.listingsAndReviews.find(
  { $or: [{ price: { $lt: 50 } }, { number_of_reviews: { $gt: 30 } }] },
  { name: 1, price: 1, number_of_reviews: 1, _id: 0 }
).limit(20);

// 2. $all: listings que tengan Wifi y Kitchen y Heating a la vez
db.listingsAndReviews.find(
  { amenities: { $all: ["Wifi", "Kitchen", "Heating"] } },
  { name: 1, amenities: 1, _id: 0 }
).limit(10);

// 3. $elemMatch: listings con una reseña de un reviewer concreto en un array de objetos
db.listingsAndReviews.find(
  { reviews: { $elemMatch: { reviewer_name: "Maria" } } },
  { name: 1, _id: 0 }
).limit(10);

// 4. $nin y $exists: tipos de propiedad distintos de House/Apartment que tengan rating
db.listingsAndReviews.find(
  { property_type: { $nin: ["House", "Apartment"] }, "review_scores.review_scores_rating": { $exists: true } },
  { name: 1, property_type: 1, "review_scores.review_scores_rating": 1, _id: 0 }
).limit(10);

// 5. $addFields: precio por huesped
db.listingsAndReviews.aggregate([
  { $match: { price: { $exists: true }, accommodates: { $gt: 0 } } },
  { $addFields: { precio_por_huesped: { $divide: ["$price", "$accommodates"] } } },
  { $project: { _id: 0, name: 1, price: 1, accommodates: 1, precio_por_huesped: 1 } },
  { $sort: { precio_por_huesped: 1 } },
  { $limit: 10 }
]);

// 6. $group por pais y tipo: cantidad y rating promedio, solo grupos con 50 o mas listings
db.listingsAndReviews.aggregate([
  {
    $group: {
      _id: { pais: "$address.country", tipo: "$property_type" },
      total: { $sum: 1 },
      rating_prom: { $avg: "$review_scores.review_scores_rating" }
    }
  },
  { $match: { total: { $gte: 50 } } },
  { $sort: { rating_prom: -1 } }
]);

// 7. $facet: dos analisis en una sola consulta (conteo por tipo y precio promedio global)
db.listingsAndReviews.aggregate([
  {
    $facet: {
      por_tipo: [
        { $group: { _id: "$property_type", total: { $sum: 1 } } },
        { $sort: { total: -1 } },
        { $limit: 5 }
      ],
      precio_global: [
        { $group: { _id: null, promedio: { $avg: "$price" } } }
      ]
    }
  }
]);

// 8. Anfitriones con mas listings ($group por host.host_id + $sort + $limit)
db.listingsAndReviews.aggregate([
  { $group: { _id: { id: "$host.host_id", nombre: "$host.host_name" }, listings: { $sum: 1 } } },
  { $sort: { listings: -1 } },
  { $limit: 5 }
]);
