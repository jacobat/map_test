Run this in a Rails console:

```ruby
u = User.find_or_initialize_by(email: "foo@example.com")
10_000.times { u.update(email: "foo@example.com") }
```
