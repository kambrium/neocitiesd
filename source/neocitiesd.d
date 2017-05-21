module neocitiesd;

import requests;
import std.json;
import std.stdio;
import std.typecons;

struct Neocities
{
    string username;
    string password;
    private enum URL = "https://neocities.org/api/";

    this(string user, string pass)
    {
        username = user;
        password = pass;
    }

    auto info() {
        return makeRequest("info", null);
    }

    auto list() {
        return makeRequest("list", null);
    }

    auto upload(string[] files) {
        // Arrange form for POST request
        MultipartForm form;
        foreach (string f; files)
        {
            auto file = File(f, "rb");
            form.add(formData(file.name, file, ["filename":file.name]));
        }
        return makeRequest("upload", form);
    }

    auto remove(string[] files) {
        // Arrange arguments for POST request
        alias KeyValue = Tuple!(string, "key", string, "value");
        KeyValue[] toBeDeleted;
        foreach (string f; files)
        {
            toBeDeleted ~= KeyValue("filenames[]", f);
        }
        return makeRequest("delete", toBeDeleted);
    }

    private auto makeRequest(T)(string urlExtension, T payload) {
        auto rq = Request();
        rq.authenticator = new BasicAuthentication(username, password);
        Response rs;
        if (urlExtension == "upload" || urlExtension == "delete")
        {
            rs = rq.post(URL ~ urlExtension, payload);
        }
        else if (urlExtension == "info" || urlExtension == "list")
        {
            rs = rq.get(URL ~ urlExtension);
        }
        auto responseValues = parseJSON(cast(string)rs.responseBody.data);
        responseValues["code"] = rs.code;
        return responseValues;
    }
}