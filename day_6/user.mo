import Main "canister:main";

actor {

    public func DoMint(){
        await Mint.mint();
    }

}