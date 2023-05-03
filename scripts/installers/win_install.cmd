@ECHO OFF

SET conda_path=%UserProfile%\Miniconda3
SET env_name=ct_env

CALL curl -S -s -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
IF %ERRORLEVEL% neq 0 GOTO miniconda_download_failed

ECHO Installing miniconda...

CALL Miniconda3-latest-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%conda_path%

ECHO Installing miniconda...Done!

CALL %conda_path%\condabin\conda activate %env_name% >nul 2>&1
IF %ERRORLEVEL%==0 GOTO timber_install_wheel

ECHO Creating virtual environment...
CALL %conda_path%\condabin\conda create -n %env_name% -c conda-forge compas -y >nul 2>&1
ECHO Creating virtual environment...Done!

ECHO Activating virtual environment...
CALL %conda_path%\condabin\conda activate %env_name%
IF %ERRORLEVEL% neq 0 GOTO conda_activate_failed
ECHO Activating virtual environment...Done

:compas_future:
ECHO Installing compas_future...
python -m pip install --force-reinstall --no-input --quiet compas_future-main.zip
ECHO Installing compas_future...Done!

:timber_install_wheel
ECHO Installing compas_timber...
python -m pip install --force-reinstall --no-input --quiet compas_timber-dev.zip
python -m compas_rhino.install
ECHO Installing compas_timber...Done!

PAUSE
EXIT /B %errorlevel%

:conda_activate_failed
ECHO Could not activate virtual environment. Exiting.
PAUSE
EXIT /B %errorlevel%

:miniconda_download_failed
ECHO Could not download miniconda. Exiting.
PAUSE
EXIT /B %errorlevel%

