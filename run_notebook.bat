@echo off
REM Runs the whole notebook (downloads data on the first run) and saves the results inside it.
REM Takes about 5-10 minutes. Progress: run_progress.txt  |  Errors: run_log.txt
cd /d "%~dp0"
set "PY="
for %%P in ("%USERPROFILE%\anaconda3\app\python.exe" "%USERPROFILE%\anaconda3\python.exe") do (
    if not defined PY if exist "%%~P" set "PY=%%~P"
)
if not defined PY set "PY=python"
echo %date% %time%  START (Python: %PY%) > run_log.txt
"%PY%" -m jupyter nbconvert --to notebook --execute --inplace --ExecutePreprocessor.timeout=-1 reddit_depression_lda.ipynb >> run_log.txt 2>&1
if errorlevel 1 (
    echo %date% %time%  FAILED - see the error above >> run_log.txt
) else (
    "%PY%" -m jupyter nbconvert --to html reddit_depression_lda.ipynb >> run_log.txt 2>&1
    echo %date% %time%  FINISHED >> run_log.txt
)
