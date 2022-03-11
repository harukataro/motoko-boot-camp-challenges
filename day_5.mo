
import principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Cycles "mo:base/Expression/Cycles";


actor{

    //Challenge1
    public func s_anonymous(): Bool {
        let principal_caller = msg.caller;
        retunr Principal.isAnonymous(principal_caller);
    };

    //Challenge2
    let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Nat);

    //Challenge3
    public func add_favorite_number(n:Nat) {
        let principal_caller = msg.caller;
        favoriteNumber.put(principal_caller, n);
    };
    
    public func show_favorite_number(): async ?Nat {
        let principal_caller = msg.caller;
        let n = favoriteNumber.get(principal_caller);
        switch(n){
            case (null){return null;}
            default{return n;}
        }
    };

    //Challenge4
    public func add_favorite_number2(n:Nat) : async Text {
        let principal_caller = msg.caller;
        let n = favoriteNumber.get(principal_caller);
        switch(n){
            case (null){
                favoriteNumber.put(principal_caller, n); 
                return "You've successfully registered your number";
            }
            case(_){
                return "You've already registered your number";
            }
        }
    };

    //Challenge5
    public func update_favorite_number(n:Nat) : {
        let principal_caller = msg.caller;
        let n = favoriteNumber.get(principal_caller);
        switch(n){
            case (null){}
            case(_){
                favoriteNumber.put(principal_caller, n); 
            }
        }
    };

    public func delete_favorite_number() : {
        let principal_caller = msg.caller;
        let n = favoriteNumber.get(principal_caller);
        switch(n){
            case (null){}
            case(_){
                favoriteNumber.delete(principal_caller); 
            }
        }
    };

    //Challenge6
    public func deposit_cycles(): async Nat {
        let received = Cycles.available();
        retunr received;
        }
    };

    //Challenge7
    public func withdraw_cycles(n: Nat) async() {
        await Caller.deposit_cycles()；
    }

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
    -> day_5_9.mo

    //Challenge10
    
}