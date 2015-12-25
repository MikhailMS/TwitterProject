/**
 * Created by aca14ml on 12/03/2015.
 */
var w = new ActiveXObject("WScript.Shell");
function increasePageNum() {
    w.run('ruby increasePageNum.rb');
}

function decreasePageNum() {
    w.run('ruby decreasePageNum.rb');
}

function resetPageNum() {
    w.run('ruby resetPageNum.rb');
}