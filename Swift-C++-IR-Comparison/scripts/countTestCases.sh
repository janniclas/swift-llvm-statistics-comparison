
cd ..
counter=0
for FILE in $(find . -name '*.swift');
do let counter=counter+1
done
echo $counter
