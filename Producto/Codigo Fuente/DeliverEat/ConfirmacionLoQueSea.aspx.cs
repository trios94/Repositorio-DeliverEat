using AccesoDatos;
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
        public AccesoDatos.PedidoLoQueSea p = new AccesoDatos.PedidoLoQueSea();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                p = (AccesoDatos.PedidoLoQueSea)Session["pedido"];
                txtCostoPedido.Text = p.CostoTotal.ToString();
                txtPedido.Text = p.Descripcion;
                txtComisión.Text = "30";
                txtPagoEfectivo.Enabled = false;
                RequiredFieldValidator10.Enabled = false;
            }

        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            AccesoDatos.ConfirmacionLoQueSea pago = new AccesoDatos.ConfirmacionLoQueSea();
            AccesoDatos.PedidoLoQueSea pedido = (AccesoDatos.PedidoLoQueSea)Session["pedido"];
            pago.IdPedido = pedido.IdPedido;
            pago.Calle = txtCalle.Text.Trim();
            pago.Numero = int.Parse(txtNumero.Text.Trim());
            pago.CodPostal = txtCodPostal.Text.Trim();
            if (txtPiso.Text.Trim() != "")
                pago.Piso = int.Parse(txtPiso.Text.Trim());
            if (txtDepartamento.Text.Trim() != "")
                pago.Departamento = txtDepartamento.Text.Trim();
            if (txtTitularTarjeta.Text.Trim() != "")
            {
                pago.PagoTarjeta = true;
                pago.TitularTarjeta = txtTitularTarjeta.Text.Trim();
                pago.NumeroTarjeta = txtNumeroTarjeta.Text.Trim();
                pago.VencimientoTarjeta = txtVencimientoTarjeta.Text.Trim();
                pago.CodSeguridadTarjeta = txtCodSeguridadTarjeta.Text.Trim();
            }
            else
            {
                if (txtPagoEfectivo.Text.Trim() != "")
                    pago.AbonaEfectivo = decimal.Parse(txtPagoEfectivo.Text.Trim());
            }

            if (ddlTipoEnvio.SelectedValue == "2")
                pago.EnvioPrioritario = true;
            else
            {
                if (txtFechaRecepcion.Text.Trim() != "")
                    pago.FechaRecepcion = txtFechaRecepcion.Text.Trim();
                if (txtHoraRecepcion.Text.Trim() != "")
                    pago.FechaRecepcion = txtHoraRecepcion.Text.Trim();
            }

            pago.FechaPago = DateTime.Now;

            try
            {
                using (var db = new DeliverEatEntities())
                {
                    db.ConfirmacionLoQueSea.Add(pago);
                    db.SaveChanges();
                }
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