import axios from "axios";

export const api = axios.create({
  baseURL: "http://10.110.18.11:9091",
});
