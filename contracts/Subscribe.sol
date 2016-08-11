import "StandardContract.sol";

contract Account is StandardContract{

}

contract Subscribe is StandardContract {

struct AccountDetails {
  string name;
  string email;
  uint balance;
}

AccountDetails [] accounts;

struct MediaDetails{
  string name;
  string URL;
  uint price;
}

MediaDetails [] media;

function Subscribe(){
  owned();

}

function addAccount(string _name, string _email) external  hasWriteRights(this,msg.sender)  returns (uint) {
  accounts[accounts.length++] = AccountDetails(_name,_email,0);
  return accounts.length;
}

function addMedia(string _name,string URL,uint _price) external  hasWriteRights(this,msg.sender)  returns (uint){
    media[media.length++] = MediaDetails(_name,URL,_price);
    return media.length;
}

}
