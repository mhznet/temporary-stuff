function left()
{
    alert("Thanks good sir");
    document.getElementById("demo").innerHTML = Date();
}function right()
{
    alert("Yea right..");
}
function submit()
{
    alert("Thanks for submitting your answers.");
}

var my_qa = new QAFile();
my_qa.setId(0);
my_qa.setQuestion("bla");
my_qa.setAnswers("bla","bli","blu","ble");
my_qa.setIndex(0);

console.log(my_qa.m_id);
console.log(my_qa.m_question);
console.log(my_qa.m_answers);
console.log(my_qa.m_index);

