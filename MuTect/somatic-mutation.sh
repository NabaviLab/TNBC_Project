PATIENT_ID=$1
cd patient_$PATIENT_ID
grep -v "REJECT" p$PATIENT_ID.vcf > p$PATIENT_ID-SomaticMutation.vcf
