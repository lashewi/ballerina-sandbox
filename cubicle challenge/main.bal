import ballerina/io;

public function main() {
    int[] userInput = [2, 2, 8, 5, 6, 8, 9];
    int[] output = allocateCubicles(userInput);
   
    io:println("Result:  " , output);
}


//refactored code
function allocateCubiclesRefactored(int[] requests) returns int[] {
    int[] temp = [];
    foreach var request in requests {
        if temp.indexOf(request) is () {
            temp.push(request);
        }
    }
    return temp.sort();
}

function allocateCubicles(int[] requests) returns int[] {
    
    int[] temp = [];
    
    if(requests.length() == 0){
    	return temp;
    }
    
    int[] arr = requests.sort();

    int j = -1;
    int itrLength = arr.length() - 1;
    foreach int i in 0 ..< itrLength {
        if(arr[i] != arr[i+1]){
            j += 1;
            temp[j] = arr[i];
        }
    }

    temp[j+1] = arr[itrLength];
    return temp;
}
