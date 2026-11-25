-- Contexto: practica nueva de PL/SQL. Trabaja sobre la tabla EMPLEADO (copia de HR.EMPLOYEES
-- creada en la primera clase) para no modificar el esquema HR original.
SET SERVEROUTPUT ON SIZE UNLIMITED

-- 1. Funcion: salario mensual mas comision de un empleado
CREATE OR REPLACE FUNCTION fn_salario_total (p_employee_id IN NUMBER)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT salary + salary * NVL(commission_pct, 0)
    INTO v_total
    FROM EMPLEADO
    WHERE employee_id = p_employee_id;

    RETURN v_total;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END fn_salario_total;
/

SELECT fn_salario_total(145) AS total_145, fn_salario_total(9999) AS total_inexistente FROM DUAL;

-- 2. Procedimiento: aumentar el salario de un departamento con validaciones
CREATE OR REPLACE PROCEDURE sp_aumentar_salario (
    p_department_id IN NUMBER,
    p_porcentaje    IN NUMBER
)
IS
BEGIN
    IF p_porcentaje <= 0 OR p_porcentaje > 30 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El porcentaje debe estar entre 0 y 30');
    END IF;

    UPDATE EMPLEADO
    SET salary = salary * (1 + p_porcentaje / 100)
    WHERE department_id = p_department_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El departamento no existe o no tiene empleados');
    END IF;

    DBMS_OUTPUT.PUT_LINE('Empleados actualizados: ' || SQL%ROWCOUNT);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END sp_aumentar_salario;
/

-- Prueba (primero con ROLLBACK para no alterar los datos de practica)
BEGIN
    sp_aumentar_salario(60, 10);
END;
/
ROLLBACK;

-- 3. Cursor FOR con parametro: reporte de un departamento, con el caso "no existe" resuelto
--    contando antes de recorrer (version simplificada del ejercicio del cursor explicito)
DECLARE
    v_depto  NUMBER := 80;
    v_existe NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_existe FROM EMPLEADO WHERE department_id = v_depto;

    IF v_existe = 0 THEN
        DBMS_OUTPUT.PUT_LINE('El departamento ' || v_depto || ' no existe o no tiene empleados');
    ELSE
        FOR r IN (SELECT e.first_name, e.last_name, e.salary
                  FROM EMPLEADO e
                  WHERE e.department_id = v_depto
                  ORDER BY e.salary DESC)
        LOOP
            DBMS_OUTPUT.PUT_LINE(r.first_name || ' ' || r.last_name || ' - ' || r.salary);
        END LOOP;
    END IF;
END;
/

-- 4. Trigger: impedir que un salario baje
CREATE OR REPLACE TRIGGER trg_no_bajar_salario
BEFORE UPDATE OF salary ON EMPLEADO
FOR EACH ROW
BEGIN
    IF :NEW.salary < :OLD.salary THEN
        RAISE_APPLICATION_ERROR(-20010, 'No se permite disminuir el salario');
    END IF;
END;
/

-- Debe fallar con ORA-20010:
UPDATE EMPLEADO SET salary = salary - 100 WHERE employee_id = 100;
ROLLBACK;
