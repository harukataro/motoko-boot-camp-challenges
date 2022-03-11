import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";
import Buffer "mo:base/Buffer";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Option "mo:base/Option";

actor{
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");
    // CRUD
    // 
    var Memos = HashMap.HashMap<Nat,Text>(0, Nat.equal, Hash.hash);
    var MemoHolder = HashMap.HashMap<Nat,Principal.Principal>(0, Nat.equal, Hash.hash);
    var KeyNum = 0;

    //Create
    public shared(msg) func create(text: Text): async ?Nat {
        if(Principal.equal(msg.caller, anonymous_principal)){
            return null;
        };
        Memos.put(KeyNum, text);
        MemoHolder.put(KeyNum, msg.caller);
        KeyNum += 1;
        return ?KeyNum;
    };

    //Read
    public func read (key: Nat): async Text{
        let ans = Option.get(Memos.get(key), "");
        ans
    };

    //Update
    public shared(msg) func update (key: Nat, text: Text): async Bool{
        if(isOwer(key, msg.caller)){
            let resp = Memos.replace(key, text);
            return true;
        };
        return false;
    };

    //Delete
    public func delete (key: Nat) :async Bool{
        let status = Memos.remove(key);
        switch(status) {
            case(null){false};
            case(_){
                let status2 = MemoHolder.remove(key);
                switch(status2) {
                    case(null){false};
                    case(_){true};
                };
            };
        };
    };

    private func isOwer(key: Nat, msg: Principal.Principal): Bool{
        let ans = Option.get(MemoHolder.get(key), anonymous_principal);
        return Principal.equal(ans, msg);
    };
}