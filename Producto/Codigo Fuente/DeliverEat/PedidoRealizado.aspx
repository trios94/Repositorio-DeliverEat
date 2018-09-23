<%@ Page Title="Pedido Realizado" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PedidoRealizado.aspx.cs" Inherits="DeliverEat.PedidoRealizado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="cover-container d-flex h-100 p-3 mx-auto flex-column">
        <main role="main" class="inner cover">
            <h1 class="cover-heading">DeliverEat! - Pedido Realizado</h1>
            <p class="lead">Su pedido N° <%= p.IdPedido %> se realizó exitosamente</p>
        </main>
    </div>
</asp:Content>
