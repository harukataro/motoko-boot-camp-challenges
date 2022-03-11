

actor{

    stable var entries: [(Principal, Nat)] = [];

    //Challenge2
    //let favoriteNumber = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Nat);
    let favoriteNumber: HashMap.fromlter<Principan, Nat>(entries.val(), 0, Principal.equal, Nat);

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

    system func preupgrade() {
        entries := Iter.toArray(favoriteNumber.entries());
    };

    system func postupgrade() {
        entries := [];
    };
}

}