#!/bin/bash
if [ $# -gt 0 ]; then
    file=$1
else
    file="ce1.out"
fi
#################
# Real frequencies
realfreqstartline=$(grep -n 'Real-axis frequencies' ${file} | awk -F ":" '{print $1+1}')
#echo "realfreqstartline = $realfreqstartline"
if [ -z $realfreqstartline ]; then
    echo "No real-axis frequencies."
else
    nrealfreq=$(grep 'Real-axis frequencies' ${file} | awk '{print $5}')
    #echo "nrealfreq = $nrealfreq"
    realfreqendline=$(echo "$realfreqstartline + $nrealfreq - 1" | bc)
    #echo "realfreqendline = $realfreqendline"

    echo "Outputing $nrealfreq real-axis frequencies to freqs_real.txt"
    sed -n "${realfreqstartline}, ${realfreqendline} p" ${file} | awk '{printf("%16.5f \n", $6)}' > freqs_real.txt
fi

#################
# Imaginary frequencies
imagfreqstartline=$(grep -n 'Imaginary-axis frequencies' ${file} | awk -F ":" '{print $1+1}')
#echo "imagfreqstartline = $imagfreqstartline"
if [ -z $imagfreqstartline ]; then
    echo "No imaginary-axis frequencies."
else
    nimagfreq=$(grep 'Imaginary-axis frequencies' ${file} | awk '{print $5}')
    #echo "nimagfreq = $nimagfreq"
    imagfreqendline=$(echo "$imagfreqstartline + $nimagfreq - 1" | bc)
    #echo "imagfreqendline = $imagfreqendline"

    echo "Outputing $nimagfreq imaginary-axis frequencies to freqs_imag.txt"
    sed -n "${imagfreqstartline}, ${imagfreqendline} p" ${file} | awk '{printf("%16.5f \n", $9)}' > freqs_imag.txt   
fi
