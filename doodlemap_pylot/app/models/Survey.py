from system.core.model import Model

class Survey(Model):
    def __init__(self):
        super(Survey, self).__init__()

    # info {
    #     "user_id"
    #     "desc"
    #     "opts":[]
    #     "lat"
    #     "lng"
    # }
    def create_survey(self, info):
        error = ""

        if len(info["desc"]) < 1:
            error = "desc cannot be empty!"
        elif len(info["opts"]) < 2:
            error = "Need at least two options!"

        if len(error) > 0:
            return { "status": False, "error": error }

        result = {}

        sql = "insert into surveys(description, created_by, created_at, updated_at, lat, lng) values(:desc, :user_id, NOW(), NOW(), :lat, :lng)"
        data = {
            "desc": info["desc"],
            "user_id": info["user_id"],
            "lat": info["lat"],
            "lng": info["lng"]
        }        
        survey_id = self.db.query_db(sql, data)

        result["survey_id"] = survey_id

        opts = {}

        for opt in info["opts"]:
            sql = "insert into options(name, survey_id, created_at, updated_at) values(:name, :survey_id, NOW(), NOW())"
            data = {
                "name": opt,
                "survey_id": survey_id
            }
            opt_id = self.db.query_db(sql, data)
            opts[opt] = opt_id

        result["opts"] = opts

        return { "status": True, "result": result }

    # info{
    #     "voter_id"
    #     "option_id"
    # }
    def vote(self, info):
        error = ""

        if len(info["option_id"]) < 1:
            error = "option_id cannot be empty!"

        if len(error) > 0:
            return { "status": False, "error": error }

        sql = "insert into votes(voter_id, option_id, created_at, updated_at) values(:voter_id, :option_id, NOW(), NOW())"
        data = {
            "voter_id": info["voter_id"],
            "option_id": info["option_id"]
        }
        self.db.query_db(sql, data)

        return { "status": True }

    # mode:
    # 0 -- all the surveys
    # 1 -- all the surveys that the user voted
    # 2 -- all the surveys that the user didn't vote
    def get_all_surveys(self, lat, lng, mode = 0, user_id = 0):
        if not mode == 0 and user_id == 0:
            return { "status": False, "error": "need to put in a user_id if mode is not 0" }

        sql = "select a.id as survey_id, a.description, b.id as opt_id, b.name as opt, count(c.option_id) as count " \
            "from surveys a " \
            "join options b on a.id = b.survey_id " \
            "left join votes c on b.id= c.option_id " \
            "where a.lat = :lat and a.lng = :lng" 
        if mode == 1:
            sql += " and c.voter_id = :voter_id "
        elif mode == 2:
            sql += " and c.voter_id <> :voter_id "
        sql += " group by a.id, a.description, b.name order by survey_id, opt_id desc"

        data = {
            "lat": lat,
            "lng": lng
        }

        records = []
        if not mode == 0:
            data["voter_id"] = user_id

        records = self.db.query_db(sql, data)

        result = {}
        for rec in records:
            topic = rec["description"]
            if topic not in result:
                new_array = []
                new_array.append(rec)
                result[topic] = new_array
            else:
                result[topic].append(rec)

        return result
        








