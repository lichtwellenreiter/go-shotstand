package controllers

import (
	beego "github.com/beego/beego/v2/server/web"
)

type HomeController struct {
	beego.Controller
}

func (c *HomeController) Get() {
	flash := beego.ReadFromRequest(&c.Controller)
	c.Data["message"] = flash.Data["notice"]
	c.TplName = "home.tpl"
}
