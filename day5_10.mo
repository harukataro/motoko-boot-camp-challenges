import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Iter "mo:base/Iter";

actor{

    stable var entries: [(Principal, Nat)] = [];

    //Challenge2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    //Challenge3
    public shared(msg) func add_favorite_number(n:Nat) {
        let principal_caller = msg.caller;
        favoriteNumber.put(principal_caller, n);
    };
    
    public shared(msg) func show_favorite_number(): async ?Nat {
        let principal_caller = msg.caller;
        let n = favoriteNumber.get(principal_caller);
        switch(n){
            case (null){ return null;};
            case (_){ return n;};
        };
    };

    //Challenge4
    public shared(msg) func add_favorite_number2(n: Nat) : async Text {
        let principal_caller = msg.caller;
        let num = favoriteNumber.get(principal_caller);
        switch(num){
            case (null){
                favoriteNumber.put(principal_caller, n); 
                return "You've successfully registered your number";
            };
            case(_){
                return "You've already registered your number";
            };
        };
    };

    //Challenge5
    public shared(msg) func update_favorite_number(n:Nat) {
        let principal_caller: Principal = msg.caller;
        let num = favoriteNumber.get(principal_caller);
        switch(num){
            case (null){};
            case(_){
                favoriteNumber.put(principal_caller, n); 
            };
        };
    };

    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        entries := [];
    };
}