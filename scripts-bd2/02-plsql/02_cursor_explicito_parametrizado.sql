-- Contexto: Cursor explicito con parametro y manejo de excepcion propia.

--Todos los empleados que trabajan en el departamento 80 y 90, seleccionar nombre del empleado, nombre del manager, el sueldo y salario mas comision 
SET SERVEROUTPUT ON SIZE UNLIMITED

DECLARE
    CURSOR CURSOR_80_90 (param_depto NUMBER) IS
SELECT e.first_name as empleado, 
    m.first_name as manager, 
    e.salary  as sueldo, 
    e.salary + (e.salary * NVL(e.commission_pct,0)) as salario_mas_comision
from hr.employees e
left join hr.employees m
on e.manager_id = m.employee_id WHERE e.department_id = param_depto;

   
nombre_empleado VARCHAR2(50);
nombre_manager VARCHAR2(50);
sueldo NUMBER;
salario_mas_comision NUMBER;
    
BEGIN
    OPEN CURSOR_80_90(80);
    LOOP
    
    FETCH CURSOR_80_90
        INTO nombre_empleado, nombre_manager, sueldo, salario_mas_comision;
                EXIT WHEN CURSOR_80_90%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE ( nombre_empleado ||'    '|| nombre_manager ||'    '|| sueldo ||'    '|| salario_mas_comision);
        
    END LOOP;
    CLOSE CURSOR_80_90;
END;

--crear una excepcion cuando el valor de departamento no exista


DECLARE
    CURSOR CURSOR_80_90 (param_depto NUMBER) IS
SELECT e.first_name as empleado, 
    m.first_name as manager, 
    e.salary  as sueldo, 
    e.salary + (e.salary * NVL(e.commission_pct,0)) as salario_mas_comision
from hr.employees e
left join hr.employees m
on e.manager_id = m.employee_id WHERE e.department_id = param_depto;

nombre_empleado VARCHAR2(50);
nombre_manager VARCHAR2(50);
sueldo NUMBER;
salario_mas_comision NUMBER;


departamento_no_existe EXCEPTION;


BEGIN

    OPEN CURSOR_80_90(80);

     FETCH CURSOR_80_90
    INTO nombre_empleado, nombre_manager, sueldo, salario_mas_comision;

    IF CURSOR_80_90%NOTFOUND THEN
        RAISE departamento_no_existe;
    END IF;

        FETCH CURSOR_80_90
        INTO nombre_empleado, nombre_manager, sueldo, salario_mas_comision;

        EXIT WHEN CURSOR_80_90%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Empleado: ' || nombre_empleado ||' Manager: ' || nombre_manager ||' Sueldo: ' || sueldo ||' Sueldo + comision: ' || salario_mas_comision
        );
     LOOP;
      FETCH CURSOR_80_90
        INTO nombre_empleado, nombre_manager, sueldo, salario_mas_comision;

        EXIT WHEN CURSOR_80_90%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'Empleado: ' || nombre_empleado ||
            ' Manager: ' || nombre_manager ||
            ' Sueldo: ' || sueldo ||
            ' Sueldo + comision: ' || salario_mas_comision
        );

    END LOOP;

    CLOSE CURSOR_80_90;

EXCEPTION
    WHEN departamento_no_existe THEN
        DBMS_OUTPUT.PUT_LINE('El departamento no existe');

END;
