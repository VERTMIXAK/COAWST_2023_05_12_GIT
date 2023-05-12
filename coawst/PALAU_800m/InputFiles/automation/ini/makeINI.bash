#!/bin/bash
source /import/home/jgpender/.runROMSintel
source /import/home/jgpender/.runPycnal

/bin/rm H* doneFlag.txt log

/import/home/jgpender/.conda/envs/pycnalEnv/bin/python ini.py > log

echo "done" > doneFlag.txt

