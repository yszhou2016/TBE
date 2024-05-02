sample=HD25-LGA3062_L0
Dir=/home/NAS/TBE   # path of data
BarcodeFile=Barcode_Target_table
conda activate crispresso2_env

perl  RUN-CRISPResso.pl  $Dir  $BarcodeFile   $sample\_1.fq.gz  $sample\_2.fq.gz
