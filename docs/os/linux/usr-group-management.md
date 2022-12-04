# Linux user and group management

```bash
$ cat /etc/group
group name:password:group id:group users
```

* `groups`: show groups to which current user belong to
* `groupmod`: modify a group
* `groupadd`: create a new group
* `groupdel`: delete an existing group
* `gpasswd` -d user2 web
* `users`: show logged in users
* `usermod`: modify user account
  * `usermod -aG group user`, add user user into group group
* `useradd`: add a user account
  * `useradd -m -c "comment" -s /path/to/shell -G group_list user_name`
  * `-m` create home
* `userdel`: delete a user account

