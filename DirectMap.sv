/**
 * A write-allocate, write-back direct-mapped cache
 */
module DirectMapCache
#(
  // bus parameters
  BUS_DATA_WIDTH = 64,
  BUS_TAG_WIDTH = 13,

  // cache parameters
  WORD_SIZE = 4,          // # bytes in a word
  LOG_WORDS_PER_LINE = 4, // log2 of # of words in a cache line
  ADDR_WIDTH = 64-6,      // input address width, does not include block-offset bits
  LOG_NUM_SETS = 10       // log2 of # of sets in the cache (= # index bits)
)
(
  // reset and clock
  input  reset,
         clk,

  // FIXME: Interface to connect to the processor

  // FIXME: Interface to connect to the bus
);

  // local parameters
  localparam WORDS_PER_LINE = 2**LOG_WORDS_PER_LINE;
  localparam WORD_SIZE_BITS = WORD_SIZE * 8;
  localparam NUM_SETS = 2**LOG_NUM_SETS;
  localparam LINE_SIZE = WORD_SIZE * WORDS_PER_LINE;
  localparam LINE_SIZE_BITS = LINE_SIZE * 8;

  // FIXME: instantiate separate SRAMs for state, tag and data
  // ...


  // FIXME: implement the cache logic
  always_comb begin
    // ...
  end
  always_ff @(posedge clk) begin
    if (reset) begin
      // reset logic: what happens on a reset
    end
    else begin
      // normal operation logic
    end
  end


  // FIXME: you should replace these with something meaningful
  assign proc_ack = 0;
  assign proc_data_out = 0;
  assign bus_req = 0;
  assign bus_reqtag = 0;
  assign bus_reqcyc = 0;
  assign bus_respack = 0;
endmodule