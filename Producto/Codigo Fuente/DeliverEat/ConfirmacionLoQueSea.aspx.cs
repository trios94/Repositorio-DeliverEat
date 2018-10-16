using Entidades;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeliverEat
{
    public partial class ConfirmacionLoQueSea : System.Web.UI.Page
    {
        public PedidoLoQueSeaE p = new PedidoLoQueSeaE();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                p = (PedidoLoQueSeaE)Session["pedido"];
                txtCostoPedido.Text = p.CostoTotal.ToString();
                txtPedido.Text = p.Descripcion;
                txtComisión.Text = "30";
                txtPagoEfectivo.Enabled = false;
                RequiredFieldValidator10.Enabled = false;
            }

        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            p = (PedidoLoQueSeaE)Session["pedido"];
            p.CalleRecepcion = txtCalle.Text.Trim();
            p.NumeroRecepcion = int.Parse(txtNumero.Text.Trim());
            p.CodPostalRecepcion = txtCodPostal.Text.Trim();
            if (txtPiso.Text.Trim() != "")
                p.PisoRecepcion = int.Parse(txtPiso.Text.Trim());
            if (txtDepartamento.Text.Trim() != "")
                p.DepartamentoRecepcion = txtDepartamento.Text.Trim();
            if (txtTitularTarjeta.Text.Trim() != "")
            {
                p.PagoTarjeta = true;
                p.TitularTarjeta = txtTitularTarjeta.Text.Trim();
                p.NumeroTarjeta = txtNumeroTarjeta.Text.Trim();
                p.VencimientoTarjeta = txtVencimientoTarjeta.Text.Trim();
                p.CodSeguridadTarjeta = txtCodSeguridadTarjeta.Text.Trim();
                p.Vuelto = 0;
            }
            else
            {
                if (txtPagoEfectivo.Text.Trim() != "")
                {
                    p.AbonaEfectivo = decimal.Parse(txtPagoEfectivo.Text.Trim());
                    p.Vuelto = decimal.Parse(txtVuelto.Text.Trim());
                }
                    
            }

            if (ddlTipoEnvio.SelectedValue == "2")
                p.EnvioPrioritario = true;
            else
            {
                if (txtFechaRecepcion.Text.Trim() != "")
                    p.FechaRecepcion = txtFechaRecepcion.Text.Trim();
                if (txtHoraRecepcion.Text.Trim() != "")
                    p.FechaRecepcion = txtHoraRecepcion.Text.Trim();
            }

            try
            {
                Session["pedido"] = p;
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al confirmar el pedido";
                return;
            }

            Response.Redirect("PedidoRealizado.aspx");
        }

        protected void ddlTipoEntrega_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlTipoEnvio.SelectedValue == "1")
            {
                RequiredFieldValidator1.Enabled = true;
                RequiredFieldValidator2.Enabled = true;
                txtFechaRecepcion.Enabled = true;
                txtHoraRecepcion.Enabled = true;
            }
            else
            {
                RequiredFieldValidator1.Enabled = false;
                RequiredFieldValidator2.Enabled = false;
                txtFechaRecepcion.Enabled = false;
                txtHoraRecepcion.Enabled = false;
            }
        }

        protected void ddlFormaPago_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlFormaPago.SelectedValue == "1")
            {
                RequiredFieldValidator10.Enabled = false;
                RequiredFieldValidator6.Enabled = true;
                RequiredFieldValidator7.Enabled = true;
                RequiredFieldValidator8.Enabled = true;
                RequiredFieldValidator9.Enabled = true;
                txtPagoEfectivo.Enabled = false;
                txtTitularTarjeta.Enabled = true;
                txtNumeroTarjeta.Enabled = true;
                txtVencimientoTarjeta.Enabled = true;
                txtCodSeguridadTarjeta.Enabled = true;
            }
            else
            {
                RequiredFieldValidator10.Enabled = true;
                RequiredFieldValidator6.Enabled = false;
                RequiredFieldValidator7.Enabled = false;
                RequiredFieldValidator8.Enabled = false;
                RequiredFieldValidator9.Enabled = false;
                txtPagoEfectivo.Enabled = true;
                txtTitularTarjeta.Enabled = false;
                txtNumeroTarjeta.Enabled = false;
                txtVencimientoTarjeta.Enabled = false;
                txtCodSeguridadTarjeta.Enabled = false;
            }
        }

        protected void txtPagoEfectivo_TextChanged(object sender, EventArgs e)
        {
            decimal pago = decimal.Parse(txtPagoEfectivo.Text.Trim());
            decimal costo = decimal.Parse(txtCostoPedido.Text.ToString());
            decimal comision = 30;
            if ((pago - costo - comision) < 0)
            {
                lblValidaPagoEfectivo.Text = "El pago en efectivo no cubre el costo del pedido";
                lblValidaPagoEfectivo.Visible = true;
            }                
            else
            {
                lblValidaPagoEfectivo.Text = "";
                txtVuelto.Text = (pago - costo - comision).ToString();
            }
                
        }
    }
}