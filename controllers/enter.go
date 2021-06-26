package controllers

import (
	"fmt"
	beego "github.com/beego/beego/v2/server/web"
	_ "github.com/go-redis/redis/v8"
	shotmodel "shotstand/models"
	"strconv"
)

type EnterController struct {
	beego.Controller
}

func (c *EnterController) Get() {
	flash := beego.ReadFromRequest(&c.Controller)

	c.Data["message"] = flash.Data["notice"]
	c.Data["groups"], _ = shotmodel.GetGroupnames()
	c.TplName = "enter.tpl"

}

func (c *EnterController) Post() {

	flash := beego.NewFlash()

	groupname := c.GetString("groupname")
	shotcount, _ := strconv.ParseInt(c.GetString("shotcount"), 10, 0)

	shotmodel.SaveShots(groupname, int(shotcount))
	flash.Notice(fmt.Sprintf("%d Shots für Gruppe %s hinzugefügt", shotcount, groupname))
	flash.Store(&c.Controller)
	c.Redirect("/enter", 302)

}
