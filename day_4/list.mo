
actor{
    public func is_null<T>(l: List<T>) : async Bool{
        switch(l){
            case (null){ 
                return true;
            };
            case (_){
                return false;
            };
        }
    }
}