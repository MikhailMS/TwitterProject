function updateRetweetUp(i) {
    document.getElementById("sort_hidden").value = "1";
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updateRetweetDown(i) {
    document.getElementById("sort_hidden").value = "2";
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updateFavouriteUp(i) {
    document.getElementById("sort_hidden").value = "3";
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updateFavouriteDown(i) {
    document.getElementById("sort_hidden").value = "4";
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updateUserUp(i) {
    document.getElementById("sort_hidden").value = "5";
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updateUserDown(i) {
    document.getElementById("sort_hidden").value = "6";
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updatePage(i) {
    document.getElementById("page_hidden").value = i;
    document.getElementById("search_form").submit();
}

function updatePageWithSort(i,sortType) {
    console.log(sortType);
    switch(sortType){
        case 1:
            updateRetweetUp(i);
            break;
        case 2:
            updateRetweetDown(i);
            break;
        case 3:
            updateFavouriteUp(i);
            break;
        case 4:
            updateFavouriteDown(i);
            break;
        case 5:
            updateUserUp(i);
            break;
        case 6:
            updateUserDown(i);
            break;
        default:
            updatePage(i);
    }
}