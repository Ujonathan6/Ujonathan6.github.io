-- Contexto: Taller de SQL: depuracion de consultas defectuosas (bloque I) e inventario de departamentos.

--Jhonatan Camilo Lozano Buitrago

--Bloque A: verificación de casos borde del esquema.


--Bloque B: reuniones internas y externas.


--Bloque C: tratamiento de valores nulos.


--Bloque D: agregación y filtrado de grupos.


--Bloque E: subconsultas correlacionadas y no correlacionadas.


--Bloque F: operaciones de conjuntos.


--Bloque G: expresiones comunes de tabla y recursión.


--Bloque H: funciones de ventana.


--Bloque I: depuración de consultas defectuosa

SELECT d.department_name, 
    COUNT(e.employee_id) as total_e
FROM hr.departments d 
LEFT JOIN hr.employees e
ON d.department_id = e.department_id
GROUP BY d.department_name;


SELECT last_name
FROM hr.employees
WHERE department_id  IN (10, 20, 30)
    or department_id is null;
    


SELECT d.department_name, COUNT(e.employee_id)
FROM hr.departments d
LEFT JOIN hr.employees e ON d.department_id = e.department_id
LEFT JOIN hr.locations l ON d.location_id = l.location_id
AND l.country_id = 'US'
GROUP BY d.department_name;


SELECT e.department_id, e.last_name, e.salary
FROM HR.employees e
JOIN (
    SELECT department_id, MAX(salary) AS max_salary
    FROM HR.employees
    GROUP BY department_id
)m ON e.department_id = m.department_id AND e.salary = m.max_salary;

SELECT AVG(commission_pct)
FROM hr.employees;

--6.2 Inventario completo de departamentos

SELECT d.department_id,
    d.department_name,
    l.city,
    c.country_name,
    COUNT (e.employee_id) as employee_count,
    AVG(e.salary) as avg_salary
FROM hr.departments d
INNER JOIN hr.locations l
ON d.location_id = l.location_id
INNER JOIN hr.countries c
ON c.country_id = l.country_id
LEFT JOIN hr.employees e 
ON d.department_id = e.department_id
GROUP BY
d.department_id,
    d.department_name,
    l.city,
    c.country_name
