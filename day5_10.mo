import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Option "mo:base/Option";
import Cycles "mo:base/ExperimentalCycles";

shared({caller = creator}) actor class Memo() = {

    let owner : Principal = creator;
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
    let PRICE = 1000; 
    var Memos = HashMap.HashMap<Nat,Text>(0, Nat.equal, Hash.hash);
    var MemoHolder = HashMap.HashMap<Nat,Principal.Principal>(0, Nat.equal, Hash.hash);
    var KeyNum = 0;

    //Create
    public shared(msg) func create(text: Text): async Int {
        if(Principal.equal(msg.caller, anonymous_principal)){
            return -1;
        };
        let cycles = Cycles.available();
        if(cycles < PRICE) {
            return -1;
        }else{
            ignore Cycles.accept(PRICE);
            Memos.put(KeyNum, text);
            MemoHolder.put(KeyNum, msg.caller);
            KeyNum += 1;
            return KeyNum;
        }


    };

    //Read
    public func read (key: Nat): async Text{
        let ans = Option.get(Memos.get(key), "");
        ans
    };

    //Update
    public shared(msg) func update (key: Nat, text: Text): async Bool{
        if(isOwerOrAdmin(key, msg.caller)){
            let resp = Memos.replace(key, text);
            return true;
        };
        return false;
    };

    //Delete
    public shared(msg) func delete (key: Nat) {
        if(isOwerOrAdmin(key, msg.caller)){
            let status = Memos.remove(key);
            let status2 = MemoHolder.remove(key);
        };
    };

    private func isOwerOrAdmin(key: Nat, p: Principal.Principal): Bool{
        let  memoOwner = Option.get(MemoHolder.get(key), anonymous_principal);
        var ans: Bool = Principal.equal(p, memoOwner);
        ans := ans or Principal.equal(p, owner);
        return ans;
    };
}