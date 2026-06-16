# CLAUDE.md

## CSS Style

Always write CSS in multi-line format — one property per line:

```css
/* correct */
.example {
  display: flex;
  align-items: center;
  gap: 8px;
}

/* incorrect */
.example { display: flex; align-items: center; gap: 8px; }
```

This applies to all files in `app/assets/stylesheets/`.

## Ruby Style

Use Ruby 3.1 hash shorthand when the key name matches the variable name:

```ruby
# correct
find_by(agency:)
{ agency:, role: }
Membership.new(user:, agency:, role: :owner)

# incorrect
find_by(agency: agency)
{ agency: agency, role: role }
Membership.new(user: user, agency: agency, role: :owner)
```

This applies everywhere: `find_by`, hash literals, method keyword arguments.
Only use the long form when key and variable differ: `{ agency_id: agency.id }`.
