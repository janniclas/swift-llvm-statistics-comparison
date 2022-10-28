SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR/..

counter=0
for FILE in $(find . -name '*.swift');
do let counter=counter+1
done
echo $counter
