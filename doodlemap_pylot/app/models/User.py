from system.core.model import Model
import re

class User(Model):
    def __init__(self):
        super(User, self).__init__()

    # user {
    #     "name"
    #     "email"
    #     "pwd"
    #     "pwd_confirm"
    # }
    def create_user(self, user):
        sql = "select * from configs where conf_key in ('email_regex', 'pwd_len') order by id"
        result = self.db.query_db(sql)

        email_regex = re.compile(result[0]["conf_value"])
        pwd_len = int(result[1]["conf_value"])

        error = ""

        if len(user["name"]) < 1:
            error = "Name cannot be blank!"
        elif len(user["email"]) < 1:
            error = "Email cannot be blank!"
        elif not email_regex.match(user["email"]):
            error = "Invalid Email format!"
        elif len(user["pwd"]) < pwd_len:
            error = "Password should be at least " + str(pwd_len) + " characters!"
        elif user["pwd"] != user["pwd_confirm"]:
            error = "Confirm password is not match with Password!"

        sql = "select * from users where email = :email"
        data = {
            "email": user["email"]
        }
        result = self.db.query_db(sql, data)
        if len(result) > 0:
            error = "This email has already been used!"

        if len(error) > 0:
            return { "status": False, "error": error }

        pwd = self.bcrypt.generate_password_hash(user["pwd"])
        sql = "insert into users(name, alias, email, password, birthday, created_at, updated_at) " \
            "values(:name, :alias, :email, :password, :birthday, NOW(), NOW())"
        data = {
            "name": user["name"],
            "email": user["email"],
            "password": pwd
        }
        
        user_id = self.db.query_db(sql, data)

        return { "status": True, "user_id": user_id }

    # info{
    #     "email"
    #     "pwd"
    # }
    def login_user(self, info):
        sql = "select * from users where email = :email"
        data = {
            "email": info["email"]
        }
        result = self.db.query_db(sql, data)

        if result == None or len(result) == 0:
            return { "status": False, "error": "Invalid email!" }

        if self.bcrypt.check_password_hash(result[0]["password"], info["pwd"]):
            return { "status": True, "user": result[0] }

        return { "status": False, "error": "Invalid password!" }

    def get_user_info(self, user_id):
        sql = "select * from users where id = :id"
        data = {
            "id": user_id
        }
        return self.db.get_one(sql, data)

    # info{
    #     "user_id"
    #     "location_addr"
    # }
    def create_fav_location(self, info):
        error = ""

        if len(info["user_id"]) < 1:
            error = "user_id cannot be empty!"
        elif len(info["location_addr"]) < 1:
            error = "location_addr cannot be empty!"

        if len(error) > 0:
            return { "status": False, "error": error }

        location_id = 0

        sql = "select * from locations where address = :addr"
        data = {
            "addr": info["location_addr"]
        }
        result = self.db.query_db(sql, data)

        if len(result) == 0:
            sql = "insert into locations(address, created_at, updated_at) values(:addr, NOW(), NOW())"
            data = {
                "addr": info["location_addr"]
            }
            location_id = self.db.query_db(sql, data)

        sql = "select * from fav_locations where user_id = :user_id and location_id = :location_id"
        data = {
            "user_id": info["user_id"]
            "location_id": location_id
        }
        result = self.db.query_db(sql, data)

        if len(result) == 0:
            sql = "insert into fav_locations(user_id, location_id) values(:user_id, :location_id)"
            data = {
                "user_id": info["user_id"]
                "location_id": location_id
            }
            self.db.query_db(sql, data)

        return { "status": True }

    # info{
    #     "user_id"
    #     "survey_id"
    # }
    def create_fav_survey(self, info):
        error = ""

        if len(info["user_id"]) < 1:
            error = "user_id cannot be empty!"
        elif len(info["survey_id"]) < 1:
            error = "survey_id cannot be empty!"

        if len(error) > 0:
            return { "status": False, "error": error }
            
        sql = "select * from fav_surveys where user_id = :user_id and survey_id = :survey_id"
        data = {
            "user_id": info["user_id"]
            "survey_id": info["survey_id"]
        }
        result = self.db.query_db(sql, data)

        if len(result) == 0:
            sql = "insert into fav_surveys(user_id, survey_id) values(:user_id, :survey_id)"
            data = {
                "user_id": info["user_id"]
                "survey_id": info["survey_id"]
            }
            self.db.query_db(sql, data)

        return { "status": True }
