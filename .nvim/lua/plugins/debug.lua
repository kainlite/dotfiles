return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { "<leader>dn", function() require("dap").step_over() end,         desc = "Step over" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step into" },
      { "<leader>do", function() require("dap").step_out() end,          desc = "Step out" },
      { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "REPL" },
      { "<leader>dt", function() require("dap").terminate() end,         desc = "Terminate" },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    opts = { icons = { expanded = "▾", collapsed = "▸" } },
    config = function(_, opts)
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
    end,
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI toggle" },
    },
  },
}
