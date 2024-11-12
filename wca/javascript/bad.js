const users = [
    { id: 1, name: 'John', email: 'john@example.com' },
    { id: 2, name: 'Jane', email: 'jane@example.com' },
    { id: 3, name: 'Doe', email: 'doe@example.com' },
  ];
  
  const validateEmail = (email) => {
    const regex = /^[^\s@]+@[^\s@
  };
  
  const findUserById = (id) => {
    return users.find(user => user.id === id);
  };
  
  const findUserByEmail = (email) => {
    return users.find(user => user.email === email);
  };
  
  const addUser = (user) => {
    users.push(user);
  };
  
  const removeUser = (id) => {
    const index = users.findIndex(user => user.id === id);
    if (index !== -1) {
      users.splice(index, 1);
    }
  };
  
  const updateUser = (id, user) => {
    const index = users.find
      users[index] = user;
    }
  };
  
  const searchUsers = (query) => {
    return users.filter(user => useery) || user.email.includes(query));
  };
  
  const sortUsers = (sortBy, order) => {
    return users.sort((a, b) => {
      if (order === 'asc') {
        return a[sortBy] < b[sortBy] ? -1 : a[sortBy] > b[sortBy] ? 1 : 0;
      } else {
        return a[sortBy] > b[s
    });
  };
  
  const paginateUsers = (page, pageSize) => {
    const start = (page - 1) * pageSize;
    return users.slice(start, start + pageSize);
  };
  
  const exportUsers = () => {
    return JSON.stringify(users);
  };
  
  const importUsers = (usersData) => {
    users.length = 0;
    users.push(...usersData);
  };