$dir=$ARGV[0];
$table=$ARGV[1];
$file1=$ARGV[2];
$file2=$ARGV[3];

#`conda activate crispresso2_env`;
#`fastp -i $dir/$file1 -I $dir/$file2 -o $file1.QC.gz -O  $file2.QC.gz`;


$i=0;
open(AA,"$dir/$table");
$line=<AA>;
while($line=<AA>)
{    chomp $line; 
     @bb=split/\s+/,$line;
     $tt=substr($bb[2],6,6);  
     $temp="$tt-$tt";   
     $s1="FA$i";  $s2="FB$i";
     $h1{$temp}=$s1;  $h2{$temp}=$s2;
     $f1{$temp}="$bb[0].R1.fastq";  $f2{$temp}="$bb[0].R2.fastq";
     open($s1,">$bb[0].R1.fastq");
     open($s2,">$bb[0].R2.fastq");
     close  $s1;  close $s2;
     $i++;
}close AA;
$number=$i;
#############################################################################
open(AA,"gunzip  -dc  $file1 | ");
open(BB,"gunzip  -dc  $file2 | ");
$i=0;
while($line=<AA>)
{   $line2=<AA>;  $line3=<AA>;   $line4=<AA>;
    $lin=<BB>;  $lin2=<BB>; $lin3=<BB>;  $lin4=<BB>;
    $s1=substr($line2,6,6);
    $s2=substr($line2,6,6);
     chomp $line2;  chomp $line4;  chomp  $lin2;  chomp $lin4;
     $line2b=substr($line2,20,130);    $line4b=substr($line4,20,130);  
     $lin2b=substr($lin2,20,130);    $lin4b=substr($lin4,20,130);  

    $temp="$s1-$s2";
    if(exists($h1{$temp}))
          {
          $str1=$h1{$temp};    $str2=$h2{$temp};
          open(FA1,">>$f1{$temp}");     
          open(FA2,">>$f2{$temp}");
          print  FA1    $line,$line2b,"\n",$line3,$line4b,"\n";
          print  FA2    $lin,$lin2b,"\n",$lin3,$lin4b,"\n";
          close   FA1;   close FA2; 
           }          
}
close AA;  close BB;

#######################################################################################
`mkdir  frequency`;
`mkdir  percentage`;
`mkdir indel`;
`mkdir pdf`;
open(AA,"$dir/$table");
$line=<AA>;
while($line=<AA>)
{  
   @bb=split/\s+/,$line;
   `CRISPResso -r1 $bb[0].R1.fastq   -r2  $bb[0].R2.fastq   --plot_window_size 10 -w 10 -wc -10 --base_editor_output   -g $bb[1] -a $bb[3]`;    
  `cp CRISPResso_on_$bb[0].R1_$bb[0].R2/Quantification_window_nucleotide_frequency_table.txt  frequency/$bb[0].BE.frequency.txt`;
  `cp CRISPResso_on_$bb[0].R1_$bb[0].R2/Quantification_window_nucleotide_percentage_table.txt  percentage/$bb[0].BE.percentage.txt`;
  `cp CRISPResso_on_$bb[0].R1_$bb[0].R2/9.Alleles_frequency_table*pdf  pdf/$bb[0].Alleles.pdf`;
  `cp CRISPResso_on_$bb[0].R1_$bb[0].R2/CRISPResso_quantification_of_editing_frequency.txt  indel/$bb[0].indel.txt`;
}
close AA;
#`cd  indel`;
#`perl  ~/total.pl`;
##############################################################################
`rm  *fastq`;
