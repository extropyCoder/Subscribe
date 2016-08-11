var subscribe;
var nameRegistry;

function setUp(){
   subscribe = Subscribe.deployed();
   nameRegistry = NameRegistry.deployed();
   return subscribe.activateContract.sendTransaction(NameRegistry.address).then(function(TxID1){
 });
}

contract('Set Up', function(accounts) {
    it("tests set up", function() {

    return setUp();
  });
});
