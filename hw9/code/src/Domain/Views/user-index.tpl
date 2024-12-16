<p>Список пользователей в хранилище</p>

      <div class="table-responsive small">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th scope="col">ID</th>
              <th scope="col">Имя</th>
              <th scope="col">Фамилия</th>
              <th scope="col">День рождения</th>
              <th scope="col">Редактирование</th>
              <th scope="col">Удаление</th>
            </tr>
          </thead>
          <tbody>
            {% for user in users %}
            <tr>       
              <td>{{ user.getUserId() }}</td>   
              <td>{{ user.getUserName() }}</td>
              <td>{{ user.getUserLastName() }}</td>
              <td>{% if user.getUserBirthday() is not empty %}
                    {{ user.getUserBirthday() | date('d.m.Y') }}
                  {% else %}
                    <b>Не задан</b>
                  {% endif %}
              <th scope="col"><button type="button" class="btn btn-secondary"><a href="/user/edit/?id_user={{ user.getUserId }}">Редактирование</a></button></th>
              <th scope="col"><button type="button" class="btn btn-danger"><a href="/user/delete/?id_user={{ user.getUserId }}">Удаление</a></button></th>
              </td>
            </tr>
            {% endfor %}
          </tbody>
        </table>
      </div>

<script>


  function delete(userId) {
  $.ajax({
    method: 'POST',
    url: "/user/delete/",
    data: { id: userId}
  }).done(function (response) {
    document.getElementById("userId" + userId).remove();
  });
}



    let maxId = $('.table-responsive tbody tr:last-child td:first-child').html();
  
    setInterval(function () {
      $.ajax({
          method: 'POST',
          url: "/user/indexRefresh/",
          data: { maxId: maxId }
      }).done(function (response) {
          // $('.content-template').html(response);

          let users = $.parseJSON(response);
          
          if(users.length != 0){
            for(var k in users){

              let row = "<tr>";

              row += "<td>" + users[k].id + "</td>";
              maxId = users[k].id;

              row += "<td>" + users[k].username + "</td>";
              row += "<td>" + users[k].userlastname + "</td>";
              row += "<td>" + users[k].userbirthday + "</td>";

              row += "</tr>";

              $('.content-template tbody').append(row);
            }
            
          }
          
      });
    }, 10000);



    
</script>