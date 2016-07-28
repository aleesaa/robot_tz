*** Settings ***
Library   com.peterservice.testers.ExpressionConverter
Documentation    *Robot Framework* Test suite.
...              See documentation for more information.

*** Test Cases ***

Сложение 
    [Documentation]   Проверка простого позитивного сложения
    [Tags]    Позитив
    [Template]    Check equals
    6+2   8.0
	
Вычитание
    [Documentation]   Проверка простого позитивного вычитания
    [Tags]    Позитив
    [Template]    Check equals
    2-1   1.0
	
Умножение
    [Documentation]   Проверка простого позитивного умножения
	[Tags]    Позитив
    [Template]    Check equals
    5*5   25.0
	
Деление
    [Documentation]   Проверка простого позитивного деления
	[Tags]    Позитив
    [Template]    Check equals	
	10/2   5.0
	
Отсечение лишних пробелов
    [Documentation]   Проверка отсечения лишних пробелов
	[Tags]    Позитив
    [Template]    Check equals	
	10 / 2   5.0
	
Деление на ноль
    [Documentation]   Проверка деления на ноль, ожидаемый результат бесконечность
	[Tags]    Позитив
    [Template]    Check equals
	5/0   Infinity

Отрицательное число в аргументе
    [Documentation]   Проверка поведения функции, когда одно из чисел в аргументе отрицательное
	[Tags]    Позитив
    [Template]    Check equals
	-1+1   0.0
	
Отрицательное число в результате
    [Documentation]   Проверка поведения функции, когда в результате должно получиться отрицательное число
	[Tags]    Негатив
    [Template]    Check equals
	-4+2  -2.0
	
Сложение: длинное число в результате
    [Documentation]   Проверка поведения функции, когда в результате должно получиться максимально длинное число, приведенное к строке
	[Tags]    Позитив
    [Template]    Check equals
	2402823500000000000000000000000000000+1000000000000000000000000000000000000   3.4028236E36
	
Деление: длинные числа в аргументах
    [Documentation]   Проверка поведения функции, когда переданы аргументы максимальной длины: float
	[Tags]    Позитив
    [Template]    Check equals
	340282350000000000000000000000000000000/340282350000000000000000000000000000000   1.0
	
Вычитание: числа больше максимальных в аргументах
    [Documentation]    Проверка поведения функции, когда переданы аргументы превышающие максимальную длину: float
	[Tags]    Негатив
    [Template]    Check equals
	3402823500000000000000000000000000000010-3402823500000000000000000000000000000009   NaN
	
Сложение: число больше максимального в результате
    [Documentation]    Проверка поведения функции, когда результат превышает максимальную длину: float
	[Tags]    Негатив
    [Template]    Check equals
	340282350000000000000000000000000000000+340282350000000000000000000000000000000   Infinity

Ошибка: Слишком сложное выражение
    [Documentation]   Проверка вывода ошибки: It's too complex
	[Tags]    Негатив
    [Template]    Check equals
	(7*7)+5   It's too complex
	
Ошибка: Нет оператора	
    [Documentation]  Проверка вывода ошибки: There is no statement
	[Tags]    Негатив
    [Template]    Check equals
	afdsfsadfsdf   There is no statement : afdsfsadfsdf
	
	
Ошибка: Исключение	
    [Documentation]   Проверка исключения, когда введен неверный формат данных
	[Tags]    Негатив
    Run Keyword and Expect Error    NumberFormatException*   Get Expression Result    null+5
	

*** Keywords ***
Check equals
    [Arguments]   ${exp}=    ${eq}=
    ${res} =    Get Expression Result    ${exp}
    Should be equal   ${res}    ${eq}