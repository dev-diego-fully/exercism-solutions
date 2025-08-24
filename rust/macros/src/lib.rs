/// A macro for creating `HashMap` instances with a convenient, literal-like syntax.
///
/// This macro provides two primary forms:
///
/// 1. An empty map: `hashmap!();`
/// 2. A map populated with one or more key-value pairs: `hashmap!(key => value, ...);`
///
/// The macro handles the creation of the map and the insertion of elements automatically.
/// It also supports an optional trailing comma at the end of the list.
#[macro_export]
macro_rules! hashmap {
    () => {
        ::std::collections::HashMap::new()
    };

    ($($key:expr => $value:expr),+ $(,)?) => {
        {
            let mut map = ::std::collections::HashMap::new();
            $(map.insert($key, $value);)*
            map
        }
    };
}