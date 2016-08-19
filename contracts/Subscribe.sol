import "StandardContract.sol";

contract Account is StandardContract{

}

contract Subscribe is StandardController {

struct AccountDetails {
  string name;
  string email;
  uint balance;
  bool active;
}

AccountDetails [] accounts;

struct MediaDetails{
  string name;
  string URL;
  uint price;
  bool active;
}

struct Rental {
  uint accountID;
  uint mediaID;
  uint startTime;
  uint duration;
  bool active;
  bool authorize;
}

MediaDetails [] media;
Rental [] rentals;

event RentalAuthorized(uint accountID,uint mediaID);
address authorizingContract;

modifier onlyAuthorizer(){if (msg.sender==authorizingContract) _}
modifier validAccount(uint _accountID){if (_accountID < accounts.length && accounts[_accountID].active==true) _}
modifier rentalAuthorizedFor(uint _accountID,uint _rentalID) {if(_rentalID<rentals.length && rentals[_rentalID].active==true && rentals[_rentalID].authorize==true ) _}

function Subscribe(){
  owned();
}

function activate(NameRegistry _registry,address _authorizingContract) onlyOwner {
  activateController(_registry,_authorizingContract);
  authorizingContract = _authorizingContract;
}


function addAccount(string _name, string _email) external  hasWriteRights(this,msg.sender)  returns (uint) {
  accounts[accounts.length++] = AccountDetails(_name,_email,0,true);
  return accounts.length;
}

function addMedia(string _name,string URL,uint _price) external  hasWriteRights(this,msg.sender)  returns (uint){
    media[media.length++] = MediaDetails(_name,URL,_price,true);
    return media.length;
}

function authorizeRental(uint _rentalID) onlyAuthorizer {
  rentals[_rentalID].authorize = true;
  RentalAuthorized(rentals[_rentalID].accountID,_rentalID);
}

}
