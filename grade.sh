CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


cp student-submission/*.java grading-area
cp TestListExamples.java grading-area
cp -r lib grading-area

cd grading-area

if ! [ -f ListExamples.java ]
then
    echo "Missing ListExamples.java in student submission"
    echo "Score: 0"
    exit
fi 

javac -cp $CPATH *.java &> compile.txt
if [ $? -ne 0 ]
then
    echo "Compilation Error"
    echo "Score: 0"
    exit
fi

javac -cp $CPATH TestListExamples.java
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > testResult.txt

if [grep -c "failure" testResult.txt]
then 
    echo "Test Successful"
    exit
fi

if [find -type f -empty]
then
    echo "Empty Files"
    exit
fi

echo "All Tests Passed!"


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
