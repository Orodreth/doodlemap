from system.core.controller import *

class Sessions(Controller):
    def __init__(self, action):
        super(Sessions, self).__init__(action)
        self.load_model("User")
   
    def index(self):
        if "user_id" in session:
            result = self.models["User"].get_user_info(session["user_id"])
            if len(result) > 0:
                return redirect("/")

        return self.load_view('sessions/index.html')

    def register(self):
        user = {
            "name": request.form["name"],
            "email": request.form["email"],
            "pwd": request.form["pwd"],
            "pwd_confirm": request.form["pwd_confirm"]
        }

        result = self.models["User"].create_user(user)

        if result["status"] == False:
            for err in result["error"]:
                flash(err, "reg")
            return redirect("/")

        session["user_id"] = result["user_id"]

        return redirect("/")

    def login(self):
        info = {
            "email": request.form["email"],
            "pwd": request.form["pwd"]
        }

        result = self.models["User"].login_user(info)

        if result["status"] == False:
            for err in result["error"]:
                flash(err, "login")
            return redirect("/sessions/index")

        session["user_id"] = result["user"]["id"]

        return redirect("/")

    def logout(self):
        if "user_id" in session:
            session.pop("user_id")

        return redirect("/")

