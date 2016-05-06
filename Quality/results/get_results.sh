#!/bin/bash

patient_id=$1
patient_dir=$HOME'/Patients/p_DS_bkm_'$patient_id
results_dir='p_DS_bkm_'$patient_id
mv $patient_dir'/*.html' $results_dir
mv $patient_dir'/*.zip' $results_dir
