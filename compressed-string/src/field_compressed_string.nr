use dep::aztec::protocol_types::{traits::{Deserialize, Serialize}, utils::field::field_from_bytes};

// A Fixedsize Compressed String.
// Essentially a special version of Compressed String for practical use.
pub struct FieldCompressedString {
    value: Field,
}

impl Serialize<1> for FieldCompressedString {
    fn serialize(self) -> [Field; 1] {
        [self.value]
    }
}

impl Deserialize<1> for FieldCompressedString {
    fn deserialize(input: [Field; 1]) -> Self {
        Self { value: input[0] }
    }
}

impl FieldCompressedString {
    pub fn is_eq(self, other: FieldCompressedString) -> bool {
        self.value == other.value
    }

    pub fn from_field(input_field: Field) -> Self {
        Self { value: input_field }
    }

    pub fn from_string(input_string: str<31>) -> Self {
        Self { value: field_from_bytes(input_string.as_bytes(), true) }
    }

    pub fn to_bytes(self) -> [u8; 31] {
        self.value.to_be_bytes()
    }
}
