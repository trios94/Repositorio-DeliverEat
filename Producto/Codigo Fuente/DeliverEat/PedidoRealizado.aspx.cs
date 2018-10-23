using Entidades;
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
        public PedidoLoQueSeaE p = new PedidoLoQueSeaE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                p = (PedidoLoQueSeaE)Session["pedido"];
            }
        }
    }
}