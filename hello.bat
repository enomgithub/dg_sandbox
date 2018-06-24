@ECHO OFF
SETLOCAL

IF "%~1"=="" GOTO :HELP

SET HELP=FALSE
IF "%~1"=="-h" SET HELP=TRUE
IF "%~1"=="--help" SET HELP=TRUE

IF %HELP%==TRUE (
    :HELP
    ECHO hello.bat [-h] [--world WORLD]
    ECHO   -h, --help     show this help message and exit
    ECHO   --world WORLD  test arg
    SET STATE=%ERRORLEVEL%
    GOTO :FINALLY
)

IF "%~1"=="--world" (
    IF "%~2"=="" (
        ECHO usage:
        ECHO hello.bat [-h] [--world WORLD]
        ECHO hello.bat: error: argument --world: expected one argument
        SET STATE=%ERRORLEVEL%
        GOTO :FINALLY
    )
) ELSE (
    GOTO :HELP
)

ECHO Activate venv...
CALL %USERPROFILE%\venv_dg\Scripts\activate.bat

python -m dg sandbox.dg --hello Hello %*
SET STATE=%ERRORLEVEL%

ECHO Deactivate venv...
CALL deactivate

:FINALLY
IF NOT %STATE%==0 (
    ECHO Error occurred.
    EXIT /b 1
) ELSE (
    ECHO Done.
    EXIT /b 0
)
