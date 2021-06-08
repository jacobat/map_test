Run this in a Rails console:

```ruby
u = User.find_or_initialize_by(email: "foo@example.com")
10_000.times { u.update(email: "foo@example.com") }
```

Observe how the time to perform the update is gradually becoming longer and
longer.

One run started at:
```
  0.000012   0.000005   0.000017 (  0.000010)
```
and after running for a bit has reached:
```
  0.001281   0.000014   0.001295 (  0.001326)
```

Now let's try wrapping the updates in transactions:

```ruby
u = User.find_or_initialize_by(email: "foo@example.com")
10.times do
  User.transaction do
    1000.times { u.update(email: "foo@example.com") }
  end  
end
```

Performance is now much more stable. All reported measurements are around:
```
  0.000007   0.000001   0.000008 (  0.000008)
```

The output is generated by the monkey patch in `config/initializers/transaction_patch.rb`.
