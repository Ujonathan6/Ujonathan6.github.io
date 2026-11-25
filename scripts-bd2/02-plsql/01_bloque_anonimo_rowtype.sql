-- Contexto: Bloque anonimo PL/SQL: variables, %TYPE vs %ROWTYPE y DBMS_OUTPUT.

/*
Autor: Jhonatan Lozano
Fecha: 22/09/2026
Descripcion: Imprime los valores para el empleado 100

v.1 - 23/09/2026 Cambio el mensaje de salida
v.2
*/


SET SERVEROUTPUT ON;
DECLARE

--vv -- tipo varchar
--vd -- tipo date
--vn -- tipo numero
--vb -- Tipo boleano
--vc -- Tipo char

--vvPrimerNombre


--vvTexto VARCHAR2 := 'Hola mundo';

--vvTexto VARCHAR2 (50);

--vvNombre VARCHAR2 (50);
--vvApellido VARCHAR2 (50);
--vnSalario NUMBER;
--vdFecha DATE;


vrEmpleado HR.EMPLOYEES%ROWTYPE;



--vvNombre   HR.EMPLOYEES.FIRST_NAME%TYPE;
   -- vvApellido HR.EMPLOYEES.LAST_NAME%TYPE;
  --  vnSalario  HR.EMPLOYEES.SALARY%TYPE;
  --  vdFecha    HR.EMPLOYEES.HIRE_DATE%TYPE;

BEGIN
    
--SELECT FIRST_NAME,
  --  LAST_NAME,
    --SALARY,
    --HIRE_DATE

SELECT * INTO vrEmpleado

--INTO --vvNombre,
  -- vvApellido,
   -- vnSalario,
   -- vdFecha
    
    



FROM HR.EMPLOYEES
WHERE EMPLOYEE_ID = 100;
    --vvTexto := 'Hola mundo soy yo';
   -- dbms_output.put_line('El empleado se llama ' || vvNombre ||' ' || vvApellido  || ' ,Tiene un salario de: ' || TO_CHAR (vnSalario) || 'y fue contratado el:' || TO_CHAR(vdFecha , 'DD-MM-YYYY'));
   DBMS_OUTPUT.PUT_LINE(
        'El empleado se llama ' ||
        vrEmpleado.FIRST_NAME || ' ' ||
        vrEmpleado.LAST_NAME ||
        ', tiene un salario de: ' ||
        TO_CHAR(vrEmpleado.SALARY) ||
        ' y fue contratado el: ' ||
        TO_CHAR(vrEmpleado.HIRE_DATE, 'DD-MM-YYYY')
    );
END;


SELECT FIRST_NAME,
    LAST_NAME,
    SALARY,
    HIRE_DATE
FROM HR.EMPLOYEES
WHERE EMPLOYEE_ID = 100;