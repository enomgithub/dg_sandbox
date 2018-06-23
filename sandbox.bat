@ECHO OFF
SETLOCAL

ECHO Activate venv...
CALL %USERPROFILE%\venv_dg\Scripts\activate.bat

python -m dg sandbox.dg %*
SET STATE=%ERRORLEVEL%

ECHO Deactivate venv...
CALL deactivate

IF NOT %STATE%==0 (
    ECHO Error occurred.
    EXIT /b 1
) ELSE (
    ECHO Done.
    EXIT /b 0
)
