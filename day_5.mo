
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/ExperimentalCycles";

actor{

    //Challenge1
    let anonymous_principal : Principal = Principal.fromText("2vxsx-fae");

    public shared(msg) func s_anonymous(): async Bool {
        let principal_caller = msg.caller;
        return Principal.equal(principal_caller, anonymous_principal);
    };

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

    public shared(msg) func delete_favorite_number() {
        let principal_caller = msg.caller;
        let n = favoriteNumber.get(principal_caller);
        switch(n){
            case (null){};
            case(_){
                favoriteNumber.delete(principal_caller); 
            };
        }
    };

    //Challenge6
    public func deposit_cycles(): async Nat {
        let received = Cycles.available();
        return received;
    };

    //Challenge7
    public func withdraw_cycles(n: Nat) {
        //await xxx.deposit_cycles();
        // will do later
    };

    //Challenge8
    stable var count = 0 :Nat;
    stable var version_number = 1 :Nat;
    public func increment_counter(): async Nat {
        count += 1;
        return count;
    };
    public func clear_counter(): async() {count := 0;};
    system func postupgrade() {version_number += 1;};

    //Challenge9
      //-> day_5_9.mo

    //Challenge10

}