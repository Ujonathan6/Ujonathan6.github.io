-- Contexto: practica nueva de SQL avanzado sobre el esquema HR de Oracle.
-- Cada ejercicio refuerza un tema visto en clase (ventanas, NULL, subconsultas, CTE).

-- 1. Los 3 empleados mejor pagados de cada departamento (funcion de ventana)
SELECT *
FROM (
    SELECT e.department_id,
           e.last_name,
           e.salary,
           DENSE_RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS posicion
    FROM HR.EMPLOYEES e
    WHERE e.department_id IS NOT NULL
)
WHERE posicion <= 3
ORDER BY department_id, posicion;

-- 2. Diferencia de salario frente al empleado contratado inmediatamente antes (LAG)
SELECT last_name,
       hire_date,
       salary,
       salary - LAG(salary) OVER (ORDER BY hire_date) AS diferencia_vs_anterior
FROM HR.EMPLOYEES
ORDER BY hire_date;

-- 3. Empleados que ganan mas que el promedio de su departamento (subconsulta correlacionada)
SELECT e.last_name, e.department_id, e.salary
FROM HR.EMPLOYEES e
WHERE e.salary > (SELECT AVG(s.salary)
                  FROM HR.EMPLOYEES s
                  WHERE s.department_id = e.department_id);

-- 4. El mismo resultado con una sola lectura de la tabla (AVG OVER)
SELECT last_name, department_id, salary
FROM (
    SELECT last_name, department_id, salary,
           AVG(salary) OVER (PARTITION BY department_id) AS promedio_depto
    FROM HR.EMPLOYEES
)
WHERE salary > promedio_depto;

-- 5. Departamentos sin empleados: NOT EXISTS (seguro frente a NULL)
SELECT d.department_name
FROM HR.DEPARTMENTS d
WHERE NOT EXISTS (SELECT 1 FROM HR.EMPLOYEES e WHERE e.department_id = d.department_id);

-- 6. Nomina por departamento y cargo con subtotales (ROLLUP)
SELECT department_id, job_id, SUM(salary) AS nomina
FROM HR.EMPLOYEES
GROUP BY ROLLUP (department_id, job_id)
ORDER BY department_id, job_id;

-- 7. Jerarquia completa con ruta y nivel (CTE recursiva)
WITH jerarquia (employee_id, last_name, manager_id, nivel, ruta) AS (
    SELECT employee_id, last_name, manager_id, 1, last_name
    FROM HR.EMPLOYEES
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.last_name, e.manager_id, j.nivel + 1, j.ruta || ' > ' || e.last_name
    FROM HR.EMPLOYEES e
    JOIN jerarquia j ON e.manager_id = j.employee_id
)
SELECT LPAD(' ', (nivel - 1) * 3) || last_name AS organigrama, nivel, ruta
FROM jerarquia
ORDER BY ruta;

-- 8. Reemplazo de NULL: comision efectiva y total anual
SELECT last_name,
       salary,
       NVL(commission_pct, 0) AS comision_pct,
       (salary * 12) + (salary * NVL(commission_pct, 0) * 12) AS total_anual
FROM HR.EMPLOYEES
ORDER BY total_anual DESC;
