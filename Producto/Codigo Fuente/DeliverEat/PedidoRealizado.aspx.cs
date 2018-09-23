using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliverEat
{
    public partial class PedidoRealizado : System.Web.UI.Page
    {
        public AccesoDatos.PedidoLoQueSea p = new AccesoDatos.PedidoLoQueSea();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                p = (AccesoDatos.PedidoLoQueSea)Session["pedido"];
            }
        }
    }
}